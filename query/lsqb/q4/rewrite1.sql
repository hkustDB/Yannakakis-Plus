## AggReduce Phase: 

# AggReduce3
# 1. aggView
create or replace view aggView8968012309964132729 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
# 2. aggJoin
create or replace view aggJoin3269789243916720973 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView8968012309964132729 where Message_hasTag_Tag.MessageId=aggView8968012309964132729.v1;

# AggReduce4
# 1. aggView
create or replace view aggView5486011715540021841 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin579924075777115201 as select v1, aggJoin3269789243916720973.annot * aggView5486011715540021841.annot as annot from aggJoin3269789243916720973 join aggView5486011715540021841 using(v1);

# AggReduce5
# 1. aggView
create or replace view aggView5203453284385147958 as select v1, SUM(annot) as annot from aggJoin579924075777115201 group by v1;
# 2. aggJoin
create or replace view aggJoin1356448886621190926 as select annot from Person_likes_Message as Person_likes_Message, aggView5203453284385147958 where Person_likes_Message.MessageId=aggView5203453284385147958.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin1356448886621190926;

# drop view aggView8968012309964132729, aggJoin3269789243916720973, aggView5486011715540021841, aggJoin579924075777115201, aggView5203453284385147958, aggJoin1356448886621190926;
