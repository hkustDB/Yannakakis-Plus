create or replace view aggView453058591967758826 as select MessageId as v1, COUNT(*) as annot from Message_hasCreator_Person as Message_hasCreator_Person group by MessageId;
create or replace view aggJoin7327026761434166424 as select MessageId as v1, annot from Person_likes_Message as Person_likes_Message, aggView453058591967758826 where Person_likes_Message.MessageId=aggView453058591967758826.v1;
create or replace view aggView4836430584697263567 as select MessageId as v1, COUNT(*) as annot from Message_hasTag_Tag as Message_hasTag_Tag group by MessageId;
create or replace view aggJoin6591058718464066739 as select v1, aggJoin7327026761434166424.annot * aggView4836430584697263567.annot as annot from aggJoin7327026761434166424 join aggView4836430584697263567 using(v1);
create or replace view aggView6595784745458546745 as select v1, SUM(annot) as annot from aggJoin6591058718464066739 group by v1;
create or replace view aggJoin6440240130121141337 as select annot from Comment_replyOf_Message as Comment_replyOf_Message, aggView6595784745458546745 where Comment_replyOf_Message.ParentMessageId=aggView6595784745458546745.v1;
select SUM(annot) as v9 from aggJoin6440240130121141337;
