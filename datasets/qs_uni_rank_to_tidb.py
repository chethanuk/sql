from seedspark.spark import SparkApps, SparkAppsException
from typing import Any, Dict, List, Tuple
from pyspark.sql.session import SparkSession
from pyspark.context import SparkContext
from pyspark.storagelevel import StorageLevel
from abc import abstractmethod


class LoadDataToTiDB(SparkApps):
    _DATASET: str = "datasets_internal"
    _TABLE: str = None

    def __init__(self, _app_name,
                 extra_configs: Dict[Any, Any] = None,
                 spark_master: str = None,
                 create_session: bool = True,
                 log_env: bool = True,
                 spark: SparkSession = None,
                 version: int = 0,
                 ):
        super().__init__(
            _app_name,
            extra_configs=extra_configs,
            spark_master=spark_master,
            log_env=log_env,
            create_session=create_session,
        )

        self.version = f"v{version}"
        if not create_session:
            self.sc = spark.sparkContext
            self.spark = spark
        else:
            self.spark_app = SparkApps(app_name=self.app_name, extra_configs=extra_configs)
            self.spark: SparkSession = self.spark_app.spark
            self.sc: SparkContext = self.spark_app.spark.sparkContext

        self.persist_level = StorageLevel.MEMORY_AND_DISK
        self.dataset_sink_loc = f"{self.destination_loc}/dataset"

    @abstractmethod
    def download(self):
        """
        Download data from Public location to S3/GCS/LocalFS for multiple usages:
        - Across various sub tasks
        - Data Quality
        """
        raise SparkAppsException("No Implementation has found for download()", NotImplementedError)

    def fs_io(
            self, sdf: DataFrame = None, extra_path: str = None, is_read: bool = False, is_inter=False
    ) -> DataFrame:

        if extra_path is not None:
            sink_loc = f"{sink_loc}/{extra_path}"

        if is_read:
            log.info(f"Reading data from FS loc: {sink_loc}")
            sdf = self.spark.read.format(self.file_format).load(sink_loc)
            log.info(f"Read SDF from {sink_loc}. Schema: {sdf.schema}")
            return sdf

        log.info(f"Writing DF with schema: {sdf.schema} \n to fs location: {sink_loc}")
        if self.file_format == "parquet":
            sdf.write.format(self.file_format).mode(self.file_save_mode).option(
                "compression", self.config.parquet_compression
            ).save(sink_loc)
        elif self.file_format == "orc":

            sdf.write.format(self.file_format).mode(self.file_save_mode).option(
                "compression", self.config.orc_compression
            ).save(sink_loc)
        else:
            log.info(f"Sink File format {self.file_format} is not implemented yet")