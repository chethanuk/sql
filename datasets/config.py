import sys
from dataclasses import dataclass, field
from lognub import log
import wget
from pathlib import Path
from typing import Any, List


@dataclass
class Config:
    env: str = "development"
    valid_env: List[Any] = field(default_factory=["development", "production", "staging"])
    timeout_seconds: int = 30
    fs_location: str = None
    data_location: str = None
    sql_location: str = None

    def __post_init__(self):
        log.info(f"Configs initiated for env: {self.env}")
        if self.env not in self.valid_env:
            log.error(f"Invalid environment passed, exiting!.")
            sys.exit(1)

        if self.fs_location is None:
            if self.env == "development":
                data_folder_path: str = Path(__file__).parent.parent.absolute().__str__()
                log.info(f"Setting dev fs_location path as {data_folder_path}")

            elif self.env == "production" or self.env == "staging":
                data_folder_path: str = f"s3://{self.env}-data/public"
                log.info(f"Setting dev fs_location path as {data_folder_path}")

            self.fs_location = data_folder_path
            log.info(f"FS_Location post init: {self.fs_location}")

        self.data_location = f"{self.fs_location}/data"
