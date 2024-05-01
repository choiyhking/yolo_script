#
# calculate MEAN and STD for the CPU usage
# Usage: python3 cal_cpu.py <data_file_name>
#

import argparse
import statistics

def calculate_statistics(data_file):
    values = []

    with open(data_file, 'r') as file:
        for line in file:
            parts = line.strip().split()
            if len(parts) >= 2:
                try:
                    value_str = parts[1].replace(',', '.')
                    value = float(value_str)
                    if value >= 100:
                        values.append(value)
                except ValueError:
                    # If conversion fails, skip this value
                    continue

    if values:
        average = statistics.mean(values)
        standard_deviation = statistics.stdev(values)
        print(f"Mean: {average:.3f}")
        print(f"STD: {standard_deviation:.3f}")
    else:
        print("No valid data found.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Calculate statistics for the CPU usage")
    parser.add_argument("data_file", help="Name of the data file")
    args = parser.parse_args()

    calculate_statistics(args.data_file)
