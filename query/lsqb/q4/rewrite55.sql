## AggReduce Phase: 

# AggReduce165
# 1. aggView
create or replace view aggView4261951958900229645 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin214632373096121561 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4261951958900229645 where Message_hasTag_Tag.MessageId=aggView4261951958900229645.v1;

# AggReduce166
# 1. aggView
create or replace view aggView1090848879966664665 as select v1, SUM(annot) as annot from aggJoin214632373096121561 group by v1;
# 2. aggJoin
create or replace view aggJoin1467427667302387603 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView1090848879966664665 where Person_likes_Message.MessageId=aggView1090848879966664665.v1;

# AggReduce167
# 1. aggView
create or replace view aggView2550710218400800005 as select v1, SUM(annot) as annot from aggJoin1467427667302387603 group by v1;
# 2. aggJoin
create or replace view aggJoin796764460235230256 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView2550710218400800005 where Comment_replyOf_Message.ParentMessageId=aggView2550710218400800005.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin796764460235230256;

# drop view aggView4261951958900229645, aggJoin214632373096121561, aggView1090848879966664665, aggJoin1467427667302387603, aggView2550710218400800005, aggJoin796764460235230256;
