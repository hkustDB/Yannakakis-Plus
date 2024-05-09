create or replace view aggView1181197496431642506 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin4847999991357521153 as select movie_id as v15, note as v9 from movie_companies as mc, aggView1181197496431642506 where mc.company_type_id=aggView1181197496431642506.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6345419794181386907 as select v15, COUNT(*) as annot from aggJoin4847999991357521153 group by v15;
create or replace view aggJoin1679911638900592535 as select id as v15, production_year as v19, annot from title as t, aggView6345419794181386907 where t.id=aggView6345419794181386907.v15 and production_year>1990;
create or replace view aggView3665877164216169617 as select v15, SUM(annot) as annot from aggJoin1679911638900592535 group by v15;
create or replace view aggJoin8322152765608540931 as select info_type_id as v3, info as v13, annot from movie_info as mi, aggView3665877164216169617 where mi.movie_id=aggView3665877164216169617.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView6024940236610186380 as select v3, SUM(annot) as annot from aggJoin8322152765608540931 group by v3;
create or replace view aggJoin3644738009045903628 as select annot from info_type as it, aggView6024940236610186380 where it.id=aggView6024940236610186380.v3;
select SUM(annot) as v27 from aggJoin3644738009045903628;
