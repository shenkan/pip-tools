Create a new playground first:

  $ virtualenv --python="$(which python)" FOO > /dev/null 2>&1
  $ . FOO/bin/activate
  $ pip install --upgrade --force-reinstall 'pip==1.5.6' > /dev/null 2>&1
  $ alias pip-dump="$TESTDIR/../bin/pip-dump"

We install argparse as it is required by the pip-dump script, but we filter it
out of the results as it is commonly installed on the host machine outside of
the virtualenv and so will not actually be installed by the following command.

  $ pip install argparse >/dev/null 2>&1

Setup:

  $ echo "python-dateutil" > requirements.txt
  $ pip install -r requirements.txt >/dev/null 2>&1

Check the output of 'pip freeze'

  $ pip freeze -lr requirements.txt | grep -v argparse
  python-dateutil==* (glob)
  ## The following requirements were added by pip --freeze:
  six==* (glob)

Next, let's see what pip-dump does:

  $ pip-dump

It should've updated requirements.txt with pinned versions of all requirements:

  $ cat requirements.txt | grep -v argparse
  python-dateutil==* (glob)
  six==* (glob)

Cleanup our playground:

  $ rm -rf FOO

