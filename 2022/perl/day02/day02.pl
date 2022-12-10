#!/usr/local/bin/perl

# A: Rock, B: Paper, C: Scissors
# X: Rock, Y: Paper, Z: Scissors

# Points: Rock 1, Paper 2, Scissors 3
# Outcome: Lose 0, Draw 3, Win 6
#
# Total Score = Points + Outcome

# Rock 1, Paper 2, Scissors 3
my %hand_shapes = (
  "A" => 1,
  "B" => 2,
  "C" => 3,
  "X" => 1,
  "Y" => 2,
  "Z" => 3
);

## Losses
# A Z (Rock, Scissors)
# B X (Paper, Rock)
# C Y (Scissors, Paper)
## Wins
# A Y (Rock, Paper)
# B Z (Paper, Scissors)
# C X (Scissors, Rock)
## Ties
# A X (Rock, Rock)
# B Y (Paper, Paper)
# C Z (Scissors, Scissors)

my %scenarios = (
  "A X" => 3,
  "A Y" => 6,
  "A Z" => 0,
  "B X" => 0,
  "B Y" => 3,
  "B Z" => 6,
  "C X" => 6,
  "C Y" => 0,
  "C Z" => 3,
);

## From ChatGPT :)
# Open the file in read mode
open(my $fh, '<', 'data.txt') or die "Could not open file: $!";

# Initialize total score
$total_score = 0;

# Read the file line by line
while (my $line = <$fh>) {
  $line =~ s/^\s+|\s+$//g ;
  my @round = split(' ', $line);

  $total_score += ($scenarios{$line} + $hand_shapes{@round[1]});
}

print "$total_score\n";

# Close the file
close($fh);
