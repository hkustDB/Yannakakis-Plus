create or replace view aggView5450764497125267005 as select id as v3 from info_type as it;
create or replace view aggJoin3962935665303487024 as select movie_id as v15, info as v13 from movie_info as mi, aggView5450764497125267005 where mi.info_type_id=aggView5450764497125267005.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView3604706812401708746 as select v15, COUNT(*) as annot from aggJoin3962935665303487024 group by v15;
create or replace view aggJoin4720790012507377631 as select id as v15, production_year as v19, annot from title as t, aggView3604706812401708746 where t.id=aggView3604706812401708746.v15 and production_year>2005;
create or replace view aggView3361792648413457795 as select v15, SUM(annot) as annot from aggJoin4720790012507377631 group by v15;
create or replace view aggJoin431654616665073514 as select company_type_id as v1, note as v9, annot from movie_companies as mc, aggView3361792648413457795 where mc.movie_id=aggView3361792648413457795.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView6771550006565225296 as select v1, SUM(annot) as annot from aggJoin431654616665073514 group by v1;
create or replace view aggJoin3587758509223943416 as select kind as v2, annot from company_type as ct, aggView6771550006565225296 where ct.id=aggView6771550006565225296.v1 and kind= 'production companies';
select SUM(annot) as v27 from aggJoin3587758509223943416;
