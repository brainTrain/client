// @flow
import Render from '.'
import {List} from 'immutable'
import {addNewPhone, addNewComputer} from '../actions/login'
import {compose, lifecycle, mapProps} from 'recompose'
import {connect} from 'react-redux'
import {createSelector} from 'reselect'
import {load, paperKeyMake} from '../actions/devices'

import type {TypedState} from '../constants/reducer'

const getAllDevicesSelector = (state: TypedState) => state.devices.get('deviceIDs')
const getDeviceEntitiesSelector = (state: TypedState) => state.entities.get('devices')

const getDevicesAndRevokedDevicesSelector = createSelector(
  getAllDevicesSelector, getDeviceEntitiesSelector,
  (allDevices, deviceEntities) => {
    const split = allDevices.groupBy(id => deviceEntities.get(id).revokedAt ? 'revokedDeviceIDs' : 'deviceIDs')
    const deviceIDs = split.get('deviceIDs', List())
    const revokedDeviceIDs = split.get('revokedDeviceIDs', List())
    return {
      deviceIDs,
      revokedDeviceIDs,
    }
  }
)

const mapStateToProps = (state: any, {routeState}) => {
  const {showingRevoked} = routeState
  const {deviceIDs, revokedDeviceIDs} = getDevicesAndRevokedDevicesSelector(state)

  return {
    deviceIDs,
    revokedDeviceIDs,
    showingRevoked,
  }
}

const mapDispatchToProps = (dispatch: any, {routeState, setRouteState}) => ({
  addNewComputer: () => dispatch(addNewComputer()),
  addNewPaperKey: () => dispatch(paperKeyMake()),
  addNewPhone: () => dispatch(addNewPhone()),
  loadDevices: () => dispatch(load()),
  onToggleShowRevoked: () => { setRouteState({showingRevoked: !routeState.showingRevoked}) },
})

const Devices = compose(
  lifecycle({
    componentWillMount: function () {
      this.props.loadDevices()
    },
  }),
  // Don't pass immutable things to dumb components
  mapProps(props => ({
    ...props,
    deviceIDs: props.deviceIDs.toArray(),
    revokedDeviceIDs: props.revokedDeviceIDs.toArray(),
  }))
)(Render)

export default connect(mapStateToProps, mapDispatchToProps)(Devices)
