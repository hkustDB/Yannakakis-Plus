## AggReduce Phase: 

# AggReduce180
# 1. aggView
create or replace view aggView3628259566739203736 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin5294053435323449399 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView3628259566739203736 where Comment_replyOf_Message.ParentMessageId=aggView3628259566739203736.v1;

# AggReduce181
# 1. aggView
create or replace view aggView5218340887911248831 as select v1, SUM(annot) as annot from aggJoin5294053435323449399 group by v1;
# 2. aggJoin
create or replace view aggJoin3267648879426709938 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView5218340887911248831 where Person_likes_Message.MessageId=aggView5218340887911248831.v1;

# AggReduce182
# 1. aggView
create or replace view aggView3881444731671976502 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
# 2. aggJoin
create or replace view aggJoin5769183446109737974 as select aggJoin3267648879426709938.annot * aggView3881444731671976502.annot as annot from aggJoin3267648879426709938 join aggView3881444731671976502 using(v1);
# Final result: 
select SUM(annot) as v9 from aggJoin5769183446109737974;

# drop view aggView3628259566739203736, aggJoin5294053435323449399, aggView5218340887911248831, aggJoin3267648879426709938, aggView3881444731671976502, aggJoin5769183446109737974;
