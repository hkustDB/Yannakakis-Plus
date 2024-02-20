## AggReduce Phase: 

# AggReduce6
# 1. aggView
create or replace view aggView2468268806125943349 as select CommentId as v3, COUNT(*) as annot, TagId as v8 from Comment_hasTag_Tag as cht2 group by CommentId,TagId;
# 2. aggJoin
create or replace view aggJoin2431090511293215957 as select ParentMessageId as v1, v8, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2468268806125943349 where Comment_replyOf_Message.CommentId=aggView2468268806125943349.v3;

# AggReduce7
# 1. aggView
create or replace view aggView7353996928894317793 as select v1, SUM(annot) as annot, v8 from aggJoin2431090511293215957 group by v1,v8;
# 2. aggJoin
create or replace view aggJoin5416674289751682352 as select TagId as v2, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView7353996928894317793 where Message_hasTag_Tag.MessageId=aggView7353996928894317793.v1 and TagId<v8;

# AggReduce8
# 1. aggView
create or replace view aggView7708136709460747030 as select TagId as v2, COUNT(*) as annot from Comment_hasTag_Tag as cht1 group by TagId;
# 2. aggJoin
create or replace view aggJoin2344325930773862433 as select aggJoin5416674289751682352.annot * aggView7708136709460747030.annot as annot from aggJoin5416674289751682352 join aggView7708136709460747030 using(v2);
# Final result: 
select SUM(annot) as v9 from aggJoin2344325930773862433;

# drop view aggView2468268806125943349, aggJoin2431090511293215957, aggView7353996928894317793, aggJoin5416674289751682352, aggView7708136709460747030, aggJoin2344325930773862433;
