function GET --wraps="curl -I -X GET"
    command curl -I -X GET $argv
end
