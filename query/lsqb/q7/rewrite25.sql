create or replace view aggView759127098168661340 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin5883304454126908083 as select ParentMessageId as v1, annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView759127098168661340 where Comment_replyOf_Message.ParentMessageId=aggView759127098168661340.v1;
create or replace view aggView49130487492831641 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin1186050457013634665 as select v1, aggJoin5883304454126908083.annot * aggView49130487492831641.annot as annot from aggJoin5883304454126908083 join aggView49130487492831641 using(v1);
create or replace view aggView6651902073272805822 as select v1, SUM(annot) as annot from aggJoin1186050457013634665 group by v1;
create or replace view aggJoin7999084281838793927 as select annot from Person_likes_Message as Person_likes_Message, aggView6651902073272805822 where Person_likes_Message.MessageId=aggView6651902073272805822.v1;
select SUM(annot) as v9 from aggJoin7999084281838793927;
