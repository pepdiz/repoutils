setup () {
  export REPOFILE=.repo
  export DIR=$(mktemp -d)
}

teardown () {
  [ -d $DIR ] && rm -rf $DIR
}

test_h_or_help_show_syntax () {
  OUT='repo-gen [dir] [repo-name]

creates a repository in folder dir with name repo-name
default: dir is current dir and repo-name is dir name'

  assert_equals "$OUT"  "$(../repo-gen -h)"
  assert_equals "$OUT"  "$(../repo-gen --help)"
}

test_h_or_help_exit_with_success () {
  assert_status_code 0 ../repo-gen -h 
  assert_status_code 0 ../repo-gen --help 
}

todo_other_flags_exit_with_error () {
  fail "not implemented"
}

test_dir_passed_is_invalid_dir () {
  NODIR=./non_existent_dir
  assert_equals "$NODIR is not a directory" "$(../repo-gen $NODIR)"
}

test_invalid_dir_should_fail_with_code_1 () {
  NODIR=./non_existent_dir
  assert_status_code 1 "../repo-gen $NODIR"
}

test_non_passing_dir_uses_current_dir () {
  CURDIR=$(pwd)
  cd $DIR
  $CURDIR/../repo-gen
  cd $PWD
  assert_status_code 0 "test -f $DIR/$REPOFILE"  
}

test_non_passing_repo_name_makes_it_dir_name () {
  DIRNAME=$(basename $DIR)
  ../repo-gen $DIR
  assert_matches ".*$DIRNAME Porteus repository.*" "$(cat $DIR/index.html)"
}

test_passing_repo_name_uses_it () {
  REPONAME=mi_repo
  ../repo-gen $DIR $REPONAME
  assert_matches ".*$REPONAME Porteus repository.*" "$(cat $DIR/index.html)"
}
