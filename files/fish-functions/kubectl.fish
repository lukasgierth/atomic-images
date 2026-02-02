function kubectl --wraps="kubectl" --description="Wraps kubectl in kubecolor"
    command kubecolor $argv
end
