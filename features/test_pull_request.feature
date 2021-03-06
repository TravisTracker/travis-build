Feature: Testing a Ruby project

  Background:
   Given the following test payload
     | repository          | travis-ci/travis-ci                                 |
     | commit              | 1234567                                             |
     | pull_request        | true                                                |
     | pull_request_number | 180                                                 |
     | config              | rvm: 1.9.2, gemfile: gemfiles/Gemfile |

  Scenario: A successful build
    When it starts a job
    Then it exports the line TRAVIS_PULL_REQUEST=true
    Then it exports the line TRAVIS_SECURE_ENV_VARS=false
     And it exports the line TRAVIS_JOB_ID=10
     And it exports the line TRAVIS_PULL_REQUEST_NUMBER=180
     And it successfully clones the repository to the build dir with git
     And it successfully checks out the commit with git to the repository directory
     And it exports the line TRAVIS_RUBY_VERSION=1.9.2
     And it successfully switches to the ruby version: 1.9.2
     And it announces active ruby version
     And it does not find the file gemfiles/Gemfile
     And it successfully runs the script: rake
     And it closes the ssh session
     And it returns the result 0
     And it has captured the following events
       | name            | data                                       |
       | job:test:start  | started_at: [now]                          |
       | job:test:log    | log: /Using worker/                        |
       | job:test:log    | log: cd ~/builds                           |
       | job:test:log    | log: export TRAVIS_PULL_REQUEST=true       |
       | job:test:log    | log: export TRAVIS_SECURE_ENV_VARS=false   |
       | job:test:log    | log: export TRAVIS_JOB_ID=10               |
       | job:test:log    | log: export TRAVIS_PULL_REQUEST_NUMBER=180 |
       | job:test:log    | log: git clone                             |
       | job:test:log    | log: cd travis-ci/travis-ci                |
       | job:test:log    | log: git checkout                          |
       | job:test:log    | log: /export TRAVIS_RUBY_VERSION=1.9.2/    |
       | job:test:log    | log: rvm use 1.9.2                         |
       | job:test:log    | log: ruby --version                        |
       | job:test:log    | log: gem --version                         |
       | job:test:log    | log: rake                                  |
       | job:test:log    | log: /Done.* 0/                            |
       | job:test:finish | finished_at: [now], result: 0              |
