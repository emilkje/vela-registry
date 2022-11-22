"intility-logging": {
	annotations: {}
	attributes: {
		appliesToWorkloads: ["deployments.apps"]
		conflictsWith: []
		podDisruptive:   true
		workloadRefPath: ""
	}
	description: "Enable logging to common infrastructure"
	labels: {}
	type: "trait"
}

template: {
	patch: {
		spec: {
			if parameter.logs != _|_ {
				selector: matchLabels: {
					if parameter.logs.structured {
						"log-format": "json"
					}
					if !parameter.logs.structured {
						"log-format": "default"
					}
					if parameter.logs.index != _|_ {
						"log-index": parameter.logs.index
					}
				}
				template: metadata: labels: {
					if parameter.logs.structured {
						"log-format": "json"
					}
					if !parameter.logs.structured {
						"log-format": "default"
					}
					if parameter.logs.index != _|_ {
						"log-index": parameter.logs.index
					}
				}
			}
		}
	}
	parameter: {
		logs?: {
			structured?: bool | *false
			index?:      string | *context.name
		}
	}
}
