create or replace view aggView8492864348333843121 as select MessageId as v1, COUNT(*) as annot from Person_likes_Message as Person_likes_Message group by MessageId;
create or replace view aggJoin3434891118282896070 as select MessageId as v1, annot from Message_hasCreator_Person as Message_hasCreator_Person, aggView8492864348333843121 where Message_hasCreator_Person.MessageId=aggView8492864348333843121.v1;
create or replace view aggView4113248503141412521 as select ParentMessageId as v1, COUNT(*) as annot from Comment_replyOf_Message as Comment_replyOf_Message group by ParentMessageId;
create or replace view aggJoin5993242787166683709 as select v1, aggJoin3434891118282896070.annot * aggView4113248503141412521.annot as annot from aggJoin3434891118282896070 join aggView4113248503141412521 using(v1);
create or replace view aggView6641921825168902926 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin2820005017741866098 as select aggJoin5993242787166683709.annot * aggView6641921825168902926.annot as annot from aggJoin5993242787166683709 join aggView6641921825168902926 using(v1);
select SUM(annot) as v9 from aggJoin2820005017741866098;
