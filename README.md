# IndieLand
🍺 Get the latest information of Taiwan Indie Music Events.

## Usage
### Installation
If you don't have [Ruby] (2.7.2) please download.

Step1. Clone the [Indie-Land].
```bash=
$ git clone https://github.com/Lobarbon/Indie-Land.git
$ cd Indie-Land
```

Step2. Install ``Bundler`` package, if you have ``Bundler`` please jump to ``Step3``.
```bash=
$ gem install bundler
```

Step3. Install ``Gemfile`` package.
```bash=
$ bundle install
```
### Running the Application
Running a Roda application is similar to running any other rack-based application that uses a ``config.ru`` file. You can start a basic server using ``rackup``:
```bash=
$ rackup
```
or
```bash=
$ rake up
```
Ruby web servers such as Unicorn and Puma also ship with their own programs that you can use to run a Roda application.

By default, the base URL we're targeting is [http://localhost:9292].

### Rakefile
Run all quality checks.
```bash=
$ rake check:all
```
Run api.
```bash=
$ rake run
```
Run tests.
```bash=
$ rake test
```
Run all quality checks.
```bash=
$ rake check:all
```
Run app.
```bash=
$ rake up
```
Clean cassette fixtures.
```bash=
$ rake vcr:clean
```

## Language of the Domain
original JSON description -> our YAML description
- title -> `event name`
- sourceWebPromote -> `website`
- showInfo -> `sessions`
    - time -> `start_time`
    - endTime -> `end_time`
    - location -> `address`
    - locationName -> `place`

## Framework
- [Bootstrap]

## Api Explore
Get Indie music information on Taiwan Open Data Platform

[Ruby]: https://www.ruby-lang.org/en/
[Bootstrap]: https://getbootstrap.com/
[http://localhost:9292]: http://localhost:9292
[Indie-Land]: https://github.com/Lobarbon/Indie-Land.git
