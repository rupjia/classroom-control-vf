#Excercise 14.1
class users::admins {
  users::managed_user { 'jose': }

  users::managed_user { 'alice':
    group => 'staff',
  }
}
