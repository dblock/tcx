# Releasing TCX

There're no hard rules about when to release tcx. Release bug fixes frequently, features not so frequently and breaking API changes rarely.

### Release

Run tests, check that all tests succeed locally.

```
bundle install
rake
```

Check that the last build succeeded in [GHA](https://github.com/dblock/tcx) for all supported platforms.

Change "Next" in [CHANGELOG.md](CHANGELOG.md) to the current date.

```
### 0.2.2 (2015/12/31)
```

Remove the line with "Your contribution here.", since there will be no more contributions to this release.

Commit your changes.

```
git add CHANGELOG.md
git commit -m "Preparing for release, 0.2.2."
git push origin master
```

Release.

```
$ rake release

tcx 0.2.2 built to pkg/tcx-0.2.2.gem.
Tagged v0.2.2.
Pushed git commits and tags.
Pushed tcx 0.2.2 to rubygems.org.
```

### Prepare for the Next Developer Iteration

Add the next release to [CHANGELOG.md](CHANGELOG.md).

```
### 0.2.3 (Next)

* Your contribution here.
```

Increment the third version number in [lib/tcx/version.rb](lib/tcx/version.rb).

Run `bundle install` to update the Gemfile.lock.

Commit your changes.

```
git add CHANGELOG.md lib/tcx/version.rb
git commit -m "Preparing for next development iteration, 0.2.3."
git push origin master
```
