## AggReduce Phase: 

# AggReduce63
# 1. aggView
create or replace view aggView4002063191734637743 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin8724146849651261555 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4002063191734637743 where Comment_replyOf_Message.ParentMessageId=aggView4002063191734637743.v1;

# AggReduce64
# 1. aggView
create or replace view aggView7611004963729576434 as select v1, SUM(annot) as annot from aggJoin8724146849651261555 group by v1;
# 2. aggJoin
create or replace view aggJoin7130122998699506453 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView7611004963729576434 where Person_likes_Message.MessageId=aggView7611004963729576434.v1;

# AggReduce65
# 1. aggView
create or replace view aggView664636901941472741 as select v1, SUM(annot) as annot from aggJoin7130122998699506453 group by v1;
# 2. aggJoin
create or replace view aggJoin882507834786444335 as select annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView664636901941472741 where Message_hasTag_Tag.MessageId=aggView664636901941472741.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin882507834786444335;

# drop view aggView4002063191734637743, aggJoin8724146849651261555, aggView7611004963729576434, aggJoin7130122998699506453, aggView664636901941472741, aggJoin882507834786444335;
