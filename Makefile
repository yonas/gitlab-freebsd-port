# $FreeBSD$

PORTNAME=	gitlab
PORTVERSION=	8.2
CATEGORIES=	www

MAINTAINER=	yonas@fizk.net
COMMENT=	Web-based Git repository manager with wiki and issue tracking

LICENSE=	MIT

RUN_DEPENDS=	\
	sudo:${PORTSDIR}/security/sudo \
	bash:${PORTSDIR}/shells/bash \
	cmake:${PORTSDIR}/devel/cmake \
	icuinfo:${PORTSDIR}/devel/icu \
	pkgconf:${PORTSDIR}/devel/pkgconf \
	git:${PORTSDIR}/devel/git \
	nginx:${PORTSDIR}/www/nginx \
	go:${PORTSDIR}/lang/go \
	ruby:${PORTSDIR}/lang/ruby21 \
	gem:${PORTSDIR}/devel/ruby-gems \
	node:${PORTSDIR}/www/node \
	logrotate:${PORTSDIR}/sysutils/logrotate \
	redis-server:${PORTSDIR}/databases/redis \
	postgres:${PORTSDIR}/databases/postgresql94-server \
	postfix:${PORTSDIR}/mail/postfix \
	krb5-config:${PORTSDIR}/security/krb5

NO_ARCH=	yes

NO_BUILD=	yes

GITLAB_USER=	git
GITLAB_GROUP=	git
USERS=		${GITLAB_USER}
GROUPS=		${GITLAB_GROUP}

USE_RC_SUBR=	gitlab

USE_GITHUB=	yes
GH_ACCOUNT=	gitlabhq
GH_PROJECT=	gitlabhq
GH_TAGNAME=	8-2-stable

GITLAB_BASE=	${PREFIX}/gitlab
GITLAB_DIR=	${GITLAB_BASE}/gitlab

PLIST_SUB+=	GITLAB_BASE="${GITLAB_BASE}" GITLAB_DIR="${GITLAB_DIR}" GITLAB_USER="${GITLAB_USER}" GITLAB_GROUP="${GITLAB_GROUP}"
SUB_LIST+=	GITLAB_BASE="${GITLAB_BASE}" GITLAB_DIR="${GITLAB_DIR}" GITLAB_USER="${GITLAB_USER}" GITLAB_GROUP="${GITLAB_GROUP}"
SUB_FILES=	pkg-message gitlab-setup

do-install:
	${MKDIR} ${STAGEDIR}${GITLAB_DIR}
	(cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${GITLAB_DIR})
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_DATA} ${FILESDIR}/nginx.conf.sample ${STAGEDIR}${EXAMPLESDIR}/nginx.conf
	${INSTALL_SCRIPT} ${WRKDIR}/gitlab-setup ${STAGEDIR}${PREFIX}/bin/gitlab-setup
	${RM} -rf ${STAGEDIR}${GITLAB_DIR}/bin/*
	@${MKDIR} ${STAGEDIR}${GITLAB_DIR}/bin/ci
	${INSTALL_SCRIPT} ${WRKSRC}/bin/ci/upgrade.rb ${STAGEDIR}${GITLAB_DIR}/bin/ci/upgrade.rb
	${INSTALL_SCRIPT} ${WRKSRC}/bin/spring ${STAGEDIR}${GITLAB_DIR}/bin/spring
	${INSTALL_SCRIPT} ${WRKSRC}/bin/pkgr_before_precompile.sh ${STAGEDIR}${GITLAB_DIR}/bin/pkgr_before_precompile.sh
	${INSTALL_SCRIPT} ${WRKSRC}/bin/check ${STAGEDIR}${GITLAB_DIR}/bin/check
	${INSTALL_SCRIPT} ${WRKSRC}/bin/rake ${STAGEDIR}${GITLAB_DIR}/bin/rake
	${INSTALL_SCRIPT} ${WRKSRC}/bin/rails ${STAGEDIR}${GITLAB_DIR}/bin/rails
	${INSTALL_SCRIPT} ${WRKSRC}/bin/background_jobs ${STAGEDIR}${GITLAB_DIR}/bin/background_jobs
	${INSTALL_SCRIPT} ${WRKSRC}/bin/bundle ${STAGEDIR}${GITLAB_DIR}/bin/bundle
	${INSTALL_SCRIPT} ${WRKSRC}/bin/upgrade.rb ${STAGEDIR}${GITLAB_DIR}/bin/upgrade.rb
	${INSTALL_SCRIPT} ${WRKSRC}/bin/web ${STAGEDIR}${GITLAB_DIR}/bin/web
	${INSTALL_SCRIPT} ${WRKSRC}/bin/rspec ${STAGEDIR}${GITLAB_DIR}/bin/rspec
	${INSTALL_SCRIPT} ${WRKSRC}/bin/spinach ${STAGEDIR}${GITLAB_DIR}/bin/spinach
	${INSTALL_SCRIPT} ${WRKSRC}/bin/mail_room ${STAGEDIR}${GITLAB_DIR}/bin/mail_room
	${INSTALL_SCRIPT} ${WRKSRC}/bin/daemon_with_pidfile ${STAGEDIR}${GITLAB_DIR}/bin/daemon_with_pidfile

.include <bsd.port.mk>
