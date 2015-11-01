# $FreeBSD$

PORTNAME=	gitlab
PORTVERSION=	8.1
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
	node:${PORTSDIR}/www/node \
	logrotate:${PORTSDIR}/sysutils/logrotate \
	redis-server:${PORTSDIR}/databases/redis \
	postgres:${PORTSDIR}/databases/postgresql94-server \
	postfix:${PORTSDIR}/mail/postfix \
	krb5-config:${PORTSDIR}/security/krb5

NO_BUILD=	yes

USE_GITHUB=	yes
GH_ACCOUNT=	gitlabhq
GH_PROJECT=	gitlabhq
GH_TAGNAME=	8-1-stable

GITLAB_BASE=	/home/gitlab

PLIST_SUB+=	GITLAB_BASE=${GITLAB_BASE}
SUB_LIST+=	GITLAB_BASE=${GITLAB_BASE}
SUB_FILES=      pkg-message

do-install:
	${MKDIR} ${STAGEDIR}${GITLAB_BASE}/gitlab
	(cd ${WRKSRC} && ${COPYTREE_SHARE} . ${STAGEDIR}${GITLAB_BASE}/gitlab)
	@${MKDIR} ${STAGEDIR}${EXAMPLESDIR}
	${INSTALL_DATA} ${FILESDIR}/nginx.conf.sample ${STAGEDIR}${EXAMPLESDIR}/nginx.conf
	${INSTALL_SCRIPT} ${FILESDIR}/gitlab-setup ${STAGEDIR}${PREFIX}/bin/gitlab-setup

.include <bsd.port.mk>
