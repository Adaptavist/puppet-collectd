define collectd::plugin::jmx::mbean(
  $object_name,
  $instance_prefix = undef,
  $instance_from   = undef,
  $table           = undef,
  $value           = {},
  $values          = undef,
  $target          = $collectd::plugin::jmx::conf_file
) {

  if $values {
    $values_for_template = $values
  } else {
    $values_for_template = [ $value ]
  }

  collectd::plugin::jmx::register { $name:
    content => template("${module_name}/plugin_jmx_mbean.conf.erb"),
    order   => 20,
    target  => $target
  }

}