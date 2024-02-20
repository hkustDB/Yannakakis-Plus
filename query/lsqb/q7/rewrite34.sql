## AggReduce Phase: 

# AggReduce102
# 1. aggView
create or replace view aggView67872367152343117 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
# 2. aggJoin
create or replace view aggJoin8388977603856346388 as select MessageId as v1, annot from Message_hasTag_Tag as Message_hasTag_Tag, aggView67872367152343117 where Message_hasTag_Tag.MessageId=aggView67872367152343117.v1;

# AggReduce103
# 1. aggView
create or replace view aggView5980815681035968934 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
# 2. aggJoin
create or replace view aggJoin4247385896021756023 as select v1, aggJoin8388977603856346388.annot * aggView5980815681035968934.annot as annot from aggJoin8388977603856346388 join aggView5980815681035968934 using(v1);

# AggReduce104
# 1. aggView
create or replace view aggView8298376015859215522 as select v1, SUM(annot) as annot from aggJoin4247385896021756023 group by v1;
# 2. aggJoin
create or replace view aggJoin5946333799040389929 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView8298376015859215522 where Comment_replyOf_Message.ParentMessageId=aggView8298376015859215522.v1;
# Final result: 
select SUM(annot) as v9 from aggJoin5946333799040389929;

# drop view aggView67872367152343117, aggJoin8388977603856346388, aggView5980815681035968934, aggJoin4247385896021756023, aggView8298376015859215522, aggJoin5946333799040389929;
