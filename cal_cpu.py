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
                    # Assuming the second value in each line is a float
                    value = float(parts[1])
                    if value > 0:
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
    parser.add_argument("data_file", help="Name of the data file containing the values")
    args = parser.parse_args()

    calculate_statistics(args.data_file)