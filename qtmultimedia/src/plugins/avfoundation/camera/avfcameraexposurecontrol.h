/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl-3.0.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or (at your option) the GNU General
** Public license version 3 or any later version approved by the KDE Free
** Qt Foundation. The licenses are as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL2 and LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-2.0.html and
** https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef AVFCAMERAEXPOSURECONTROL_H
#define AVFCAMERAEXPOSURECONTROL_H

#include <QtMultimedia/qcameraexposurecontrol.h>
#include <QtMultimedia/qcameraexposure.h>

#include <QtCore/qglobal.h>

QT_BEGIN_NAMESPACE

class AVFCameraSession;
class AVFCameraService;

class AVFCameraExposureControl : public QCameraExposureControl
{
    Q_OBJECT

public:
    AVFCameraExposureControl(AVFCameraService *service);

    bool isParameterSupported(ExposureParameter parameter) const Q_DECL_OVERRIDE;
    QVariantList supportedParameterRange(ExposureParameter parameter,
                                         bool *continuous) const Q_DECL_OVERRIDE;

    QVariant requestedValue(ExposureParameter parameter) const Q_DECL_OVERRIDE;
    QVariant actualValue(ExposureParameter parameter) const Q_DECL_OVERRIDE;
    bool setValue(ExposureParameter parameter, const QVariant &value) Q_DECL_OVERRIDE;

private Q_SLOTS:
    void cameraStateChanged();

private:
    AVFCameraService *m_service;
    AVFCameraSession *m_session;

    QVariant m_requestedMode;
    QVariant m_requestedCompensation;
    QVariant m_requestedShutterSpeed;
    QVariant m_requestedISO;

    // Aux. setters:
    bool setExposureMode(const QVariant &value);
    bool setExposureCompensation(const QVariant &value);
    bool setShutterSpeed(const QVariant &value);
    bool setISO(const QVariant &value);
};

QT_END_NAMESPACE

#endif
