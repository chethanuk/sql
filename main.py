#!/workspace/gitpod-k3s/.venv/bin/python
import argparse
from seedspark.spark import SparkApps
from datasets import LoadDataToTiDB

if __name__ == '__main__':
    # Init and add arguments the parser
    parser = argparse.ArgumentParser()
    parser.add_argument("--task", "-t", default="NoneTask", type=str, help="Default Task Name")
    args = parser.parse_args()
    task = args.task
    s = LoadDataToTiDB()
    print(s)
