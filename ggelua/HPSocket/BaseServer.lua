-- @Author              : GGELUA
-- @Last Modified by    : baidwwy
-- @Date                : 2022-03-07 18:52:00
-- @Last Modified time  : 2022-11-12 04:59:51

local HPS = require('HPSocket.HPSocket')
local BaseServer = class 'BaseServer'

--描述：向指定连接发送 4096 KB 以下的小文件
function BaseServer:发送小文件(dwConnID, lpszFileName, pHead, pTail)
    return self._hp:SendSmallFile(dwConnID, lpszFileName, pHead, pTail)
end

--====================================================================================
--  /* 设置 Accept 预投递数量（根据负载调整设置，Accept 预投递数量越大则支持的并发连接请求越多） */
function BaseServer:置预投递数量(v)
    self._hp:SetAcceptSocketCount(v)
    return self
end

--  /* 设置通信数据缓冲区大小（根据平均通信数据包大小调整设置，通常设置为 1024 的倍数） */
function BaseServer:置缓冲区大小(v)
    self._hp:SetSocketBufferSize(v)
    return self
end

--  /* 设置监听 Socket 的等候队列大小（根据并发连接数量调整设置） */
function BaseServer:置等候队列大小(v)
    self._hp:SetSocketListenQueue(v)
    return self
end

--  /* 设置心跳包间隔（毫秒，0 则不发送心跳包） */
function BaseServer:置正常心跳间隔(v)
    self._hp:SetKeepAliveTime(v)
    return self
end

--  /* 设置心跳确认包检测间隔（毫秒，0 不发送心跳包，如果超过若干次 [默认：WinXP 5 次, Win7 10 次] 检测不到心跳确认包则认为已断线） */
function BaseServer:置异常心跳间隔(v)
    self._hp:SetKeepAliveInterval(v)
    return self
end

--====================================================================================
--  /* 获取 Accept 预投递数量 */
function BaseServer:取预投递数量()
    return self._hp:GetAcceptSocketCount()
end

--  /* 获取通信数据缓冲区大小 */
function BaseServer:取缓冲区大小()
    return self._hp:GetSocketBufferSize()
end

--  /* 获取监听 Socket 的等候队列大小 */
function BaseServer:取等候队列大小()
    return self._hp:GetSocketListenQueue()
end

--  /* 获取正常心跳包间隔 */
function BaseServer:取正常心跳间隔()
    return self._hp:GetKeepAliveTime()
end

--  /* 获取异常心跳包间隔 */
function BaseServer:取异常心跳间隔()
    return self._hp:GetKeepAliveInterval()
end

--====================================================================================
function BaseServer:启动(ip, port) --IServer
    return self._hp:Start(ip, port)
end

--/* 获取监听 Socket 的地址信息 */
function BaseServer:取监听地址() --IServer
    return self._hp:GetListenAddress()
end

function BaseServer:停止()
    self._hp:Stop()
    return self
end

function BaseServer:发送(dwConnID, pBuffer, iOffset)
    return self._hp:Send(dwConnID, pBuffer, iOffset)
end

function BaseServer:暂停接收(dwConnID, bPause)
    return self._hp:PauseReceive(dwConnID, bPause)
end

-- 连接 ID-- 是否强制断开连接
function BaseServer:断开(dwConnID, bForce)
    return self._hp:Disconnect(dwConnID, bForce)
end

-- 时长（毫秒）-- 是否强制断开连接
function BaseServer:断开超时(dwPeriod, bForce)
    return self._hp:DisconnectLongConnections(dwPeriod, bForce)
end

--描述：断开超过指定时长的静默连接
-- 时长（毫秒）-- 是否强制断开连接
function BaseServer:断开静默(dwPeriod, bForce)
    return self._hp:DisconnectSilenceConnections(dwPeriod, bForce)
end

--描述：等待通信组件停止运行
function BaseServer:等待(dwMilliseconds)
    return self._hp:Wait(dwMilliseconds)
end

function BaseServer:是否启动()
    return self._hp:HasStarted()
end

function BaseServer:取状态()
    return HPS[self._hp:GetState()]
end

--  /* 获取连接数 */
function BaseServer:取连接数()
    return self._hp:GetConnectionCount()
end

--/* 获取所有连接的 CONNID */
function BaseServer:取所有连接ID()
    return self._hp:GetAllConnectionIDs()
end

--  /* 获取某个连接时长（毫秒） */
function BaseServer:取连接时长(dwConnID)
    return self._hp:GetConnectPeriod(dwConnID)
end

--  /* 获取某个连接静默时间（毫秒） */
function BaseServer:取静默时长(dwConnID)
    return self._hp:GetSilencePeriod(dwConnID)
end

--  /* 获取某个连接的本地地址信息 */
function BaseServer:取本地地址(dwConnID)
    return self._hp:GetLocalAddress(dwConnID)
end

--/* 获取某个连接的远程地址信息 */
function BaseServer:取远程地址(dwConnID)
    return self._hp:GetRemoteAddress(dwConnID)
end

--  /* 获取最近一次失败操作的错误代码 */
-- SE_OK                      // 成功
-- SE_ILLEGAL_STATE           // 当前状态不允许操作
-- SE_INVALID_PARAM           // 非法参数
-- SE_Socket_CREATE           // 创建 Socket 失败
-- SE_Socket_BIND             // 绑定 Socket 失败
-- SE_Socket_PREPARE          // 设置 Socket 失败
-- SE_Socket_LISTEN           // 监听 Socket 失败
-- SE_CP_CREATE               // 创建完成端口失败
-- SE_WORKER_THREAD_CREATE    // 创建工作线程失败
-- SE_DETECT_THREAD_CREATE    // 创建监测线程失败
-- SE_SOCKE_ATTACH_TO_CP      // 绑定完成端口失败
-- SE_CONNECT_SERVER          // 连接服务器失败
-- SE_NETWORK                 // 网络错误
-- SE_DATA_PROC               // 数据处理错误
-- SE_DATA_SEND               // 数据发送失败
function BaseServer:取错误代码()
    return self._hp:GetLastError()
end

--  /* 获取最近一次失败操作的错误描述 */
function BaseServer:取错误描述()
    return self._hp:GetLastErrorDesc()
end

--/* 获取连接中未发出数据的长度 */
function BaseServer:取未发出数据长度(dwConnID)
    return self._hp:GetPendingDataLength(dwConnID)
end

--/* 获取连接的数据接收状态 */
function BaseServer:是否暂停接收(dwConnID)
    return self._hp:IsPauseReceive(dwConnID)
end

function BaseServer:是否已连接(dwConnID)
    return self._hp:IsConnected(dwConnID)
end

-- RAP_NONE            不重用
-- RAP_ADDR_ONLY       仅重用地址
-- RAP_ADDR_AND_PORT   重用地址和端口
function BaseServer:置地址重用策略(enReusePolicy)
    self._hp:SetReuseAddressPolicy(enReusePolicy)
    return self
end

--/* 设置数据发送策略 */
--  SP_PACK     // 打包模式（默认）
--  SP_SAFE     // 安全模式
--  SP_DIRECT   // 直接模式
function BaseServer:置数据发送策略(enSendPolicy)
    self._hp:SetSendPolicy(enSendPolicy)
    return self
end

--设置 OnSend 事件同步策略（默认：OSSP_NONE，不同步） */
-- OSSP_NONE       // 不同步（默认）
-- OSSP_CLOSE      // 同步 OnClose
-- OSSP_RECEIVE    // 同步 OnReceive（只用于 TCP 组件）
function BaseServer:置发送事件策略(enSyncPolicy)
    self._hp:SetOnSendSyncPolicy(enSyncPolicy)
    return self
end

--  /* 设置最大连接数（组件会根据设置值预分配内存，因此需要根据实际情况设置，不宜过大）*/
function BaseServer:置最大连接数(dwMaxConnectionCount)
    self._hp:SetMaxConnectionCount(dwMaxConnectionCount)
    return self
end

--/* 设置 Socket 缓存对象锁定时间（毫秒，在锁定期间该 Socket 缓存对象不能被获取使用） */
function BaseServer:置缓存对象锁定时间(dwFreeSocketObjLockTime)
    self._hp:SetFreeSocketObjLockTime(dwFreeSocketObjLockTime)
    return self
end

--/* 设置 Socket 缓存池大小（通常设置为平均并发连接数量的 1/3 - 1/2） */
function BaseServer:置Socket缓存池大小(dwFreeSocketObjPool)
    self._hp:SetFreeSocketObjPool(dwFreeSocketObjPool)
    return self
end

--/* 设置内存块缓存池大小（通常设置为 Socket 缓存池大小的 2 - 3 倍） */
function BaseServer:置内存块缓存池大小(dwFreeBufferObjPool)
    self._hp:SetFreeBufferObjPool(dwFreeBufferObjPool)
    return self
end

--/* 设置 Socket 缓存池回收阀值（通常设置为 Socket 缓存池大小的 3 倍） */
function BaseServer:置Socket缓存池回收阀值(dwFreeSocketObjHold)
    self._hp:SetFreeSocketObjHold(dwFreeSocketObjHold)
    return self
end

--/* 设置内存块缓存池回收阀值（通常设置为内存块缓存池大小的 3 倍） */
function BaseServer:置内存块缓存池回收阀值(dwFreeBufferObjHold)
    self._hp:SetFreeBufferObjHold(dwFreeBufferObjHold)
    return self
end

--/* 设置工作线程数量（通常设置为 2 * CPU + 2） */
function BaseServer:置工作线程数量(dwWorkerThreadCount)
    self._hp:SetWorkerThreadCount(dwWorkerThreadCount)
    return self
end

--/* 设置是否标记静默时间（设置为 TRUE 时 DisconnectSilenceConnections() 和 GetSilencePeriod() 才有效，默认：FALSE） */
function BaseServer:置静默时间(bMarkSilence)
    self._hp:SetMarkSilence(bMarkSilence)
    return self
end

--/* 获取地址重用选项 */
function BaseServer:取地址重用策略()
    return self._hp:GetReuseAddressPolicy()
end

--/* 获取数据发送策略 */
function BaseServer:取数据发送策略()
    return self._hp:GetSendPolicy()
end

--/* 获取 OnSend 事件同步策略 */
function BaseServer:取发送事件策略()
    return self._hp:GetOnSendSyncPolicy()
end

--/* 获取最大连接数 */
function BaseServer:取最大连接数()
    return self._hp:GetMaxConnectionCount()
end

--/* 获取 Socket 缓存对象锁定时间 */
function BaseServer:取缓存对象锁定时间()
    return self._hp:GetFreeSocketObjLockTime()
end

--/* 获取 Socket 缓存池大小 */
function BaseServer:取Socket缓存池大小()
    return self._hp:GetFreeSocketObjPool()
end

--/* 获取内存块缓存池大小 */
function BaseServer:取内存块缓存池大小()
    return self._hp:GetFreeBufferObjPool()
end

--/* 获取 Socket 缓存池回收阀值 */
function BaseServer:取Socket缓存池回收阀值()
    return self._hp:GetFreeSocketObjHold()
end

--/* 获取内存块缓存池回收阀值 */
function BaseServer:取内存块缓存池回收阀值()
    return self._hp:GetFreeBufferObjHold()
end

--/* 获取工作线程数量 */
function BaseServer:取工作线程数量()
    return self._hp:GetWorkerThreadCount()
end

--/* 检测是否标记静默时间 */
function BaseServer:是否静默()
    return self._hp:IsMarkSilence()
end

return BaseServer
