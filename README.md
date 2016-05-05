# Culture Amp Code Test by Fred Wu

## Prerequisite

- ruby 2.2+
- bundler

```bash
bundle install
```

## Usage

```bash
./bin/survey-tool --help

Example usage:
    -s, --survey FILE                Survey data input file
    -r, --responses FILE             Responses data input file
```

```bash
./bin/survey-tool -s example-data/survey-1.csv -r example-data/survey-1-responses.csv
```

## Application Architecture

        +----------------------------+
        |             CLI            |
        +--------------+-------------+
                       |
    +------------------v-----------------+
    |              Workflow              |
    +------------------------------------+
    |   +----------------------------+   |
    |   |         Transformer        |   | <- Transforms text input for consumption.
    |   +--------------+-------------+   |
    |                  |                 |
    |   +--------------v-------------+   |
    |   |          Producer          |   | <- Produces metrics.
    |   +----------------------------+   |
    |   |  +----------------------+  |   |
    |   |  |        Models        |  |   | <- Domain models.
    |   |  +----------------------+  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  |     Survey     |  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  | SurveyQuestion |  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  |  |    Response    |  |  |   |
    |   |  |  +----------------+  |  |   |
    |   |  +----------------------+  |   |
    |   +--------------+-------------+   |
    |                  |                 |
    |   +--------------v-------------+   |
    |   |          Presenter         |   | <- Presents metrics.
    |   +----------------------------+   |
    +------------------+-----------------+

## Test Suite

### Run all the tests

```bash
bundle exec rake
```

### Run only Rubocop

```bash
bundle exec rake rubocop
```

### Run only spec

```bash
bundle exec rake spec
```

## Author

- Fred Wu <ifredwu@gmail.com>
- 2016-05-16
