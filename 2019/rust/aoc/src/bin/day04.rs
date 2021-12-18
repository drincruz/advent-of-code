// Day04.
//
// Part01
// Given a range, find how many different passwords would be within
// the range that meets the following criteria:
//  - 6-digit number
//  - value within range
//  - two adjacent numbers are the same
//  - Numbers from left to right are increasing
//    * 111123
//    * 135679
//
// Part02
// Same password rules except now, two adjacent matching digits must not
// be part of a larger group of matching digits.
// e.g. 111234 is not a valid repeat, but 111233 is because 33 is a proper double.
//
// My puzzle input is: 137683-596253
fn main() {
    let mut valid_passwords: i32 = 0;
    for n in 137683..596253 {
        let digits: Vec<u32> = get_num_digits(n);
        if valid_format(&digits) && has_valid_repeat(&digits) {
            valid_passwords += 1;
        }
    }

    println!("{} valid_passwords", valid_passwords);
}

fn get_num_digits(n: i32) -> Vec<u32> {
    n.to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap())
        .collect()
}

fn valid_format(digits: &[u32]) -> bool {
    let mut repeat_numbers: i32 = 0;
    let mut digit_iter = digits.iter().peekable();
    while let Some(cur) = digit_iter.next() {
        if let Some(next) = digit_iter.peek() {
            if cur == *next {
                repeat_numbers += 1;
            } else if cur > next {
                return false;
            }
        }
    }

    return repeat_numbers > 0;
}

fn has_valid_repeat(digits: &[u32]) -> bool {
    let mut repeat_count: i32 = 1;
    let mut repeats: Vec<i32> = Vec::new();
    let mut digit_iter = digits.iter().peekable();
    while let Some(cur) = digit_iter.next() {
        if let Some(next) = digit_iter.peek() {
            if cur == *next {
                repeat_count += 1;
            } else {
                if repeat_count > 1 {
                    repeats.push(repeat_count);
                }
                repeat_count = 1;
            }
        }
    }
    if repeat_count > 1 {
        repeats.push(repeat_count);
    }

    for n in &repeats {
        if *n == 2 {
            return true;
        }
    }
    return false;
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn test_valid_format() {
        let digits: Vec<u32> = get_num_digits(123455);
        assert_eq!(valid_format(&digits), true);
        let decreasing_digits: Vec<u32> = get_num_digits(554321);
        assert_eq!(valid_format(&decreasing_digits), false);
    }

    #[test]
    fn test_has_valid_repeat() {
        let digits: Vec<u32> = get_num_digits(123455);
        assert_eq!(has_valid_repeat(&digits), true);
        let decreasing_digits: Vec<u32> = get_num_digits(554321);
        assert_eq!(has_valid_repeat(&decreasing_digits), true);
        let valid_pairs: Vec<u32> = get_num_digits(111223);
        assert_eq!(has_valid_repeat(&valid_pairs), true);
        let invalid_repeat: Vec<u32> = get_num_digits(111234);
        assert_eq!(has_valid_repeat(&invalid_repeat), false);
    }
}
