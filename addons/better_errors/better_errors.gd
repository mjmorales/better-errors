class_name BetterErrors

class Err:
	var _code: int
	var _message: String

	func _init(code: int, message: String):
			self._code = code
			self._message = message

	func is_null() -> bool:
			return _code == OK

	func unwrap() -> String:
			if is_null():
					return ""
			else:
					return _message

class ValueWrapper:
	var _value

	func _init(value):
			self._value = value

	func get_value():
			return _value

	func set_value(new_value):
			_value = new_value

class Result:
	var _value: ValueWrapper
	var error: Err
	
	func _init(value=null, error: Err=null):
			self._value = ValueWrapper.new(value)
			self.error = error
	
	func is_ok() -> bool:
			return error == null or error.is_null()
	
	func is_err() -> bool:
			return not is_ok()
	
	func unwrap():
			if is_ok():
					return _value.get_value()
			else:
					push_error(error.message)
					return null
	
	func expect(message: String):
			if is_err():
					push_error(message)
					return null
			else:
					return _value.get_value()
	
	func set_value(value) -> void:
			_value.set_value(value)
	
	func get_value():
			return _value.get_value()

static func ok(value=null) -> Result:
	return Result.new(value)

static func err(code: int, message: String) -> Result:
	return Result.new(null, Err.new(code, message))
