## AggReduce Phase: 

# AggReduce165
# 1. aggView
create or replace view aggView8474255324452831091 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4690791406691064370 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView8474255324452831091 where Person_likes_Message.MessageId=aggView8474255324452831091.v1;

# AggReduce166
# 1. aggView
create or replace view aggView4199519710972796787 as select v1, SUM(annot) as annot from aggJoin4690791406691064370 group by v1;
# 2. aggJoin
create or replace view aggJoin4456085843148187346 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView4199519710972796787 where Message_hasTag_Tag.MessageId=aggView4199519710972796787.v1;

# AggReduce167
# 1. aggView
create or replace view aggView4853740845960207708 as select v1, SUM(annot) as annot from aggJoin4456085843148187346 group by v1;
# 2. aggJoin
create or replace view aggJoin2231449766929955864 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView4853740845960207708 where Comment_replyOf_Message.ParentMessageId=aggView4853740845960207708.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin2231449766929955864;

# drop view aggView8474255324452831091, aggJoin4690791406691064370, aggView4199519710972796787, aggJoin4456085843148187346, aggView4853740845960207708, aggJoin2231449766929955864;
