create or replace view aggView1516388889331742404 as select id as v3 from info_type as it;
create or replace view aggJoin8762319978380401576 as select movie_id as v15, info as v13 from movie_info as mi, aggView1516388889331742404 where mi.info_type_id=aggView1516388889331742404.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView5485336584214925770 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2936041546363688477 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5485336584214925770 where mc.company_type_id=aggView5485336584214925770.v1 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView6593729508090027615 as select v15 from aggJoin8762319978380401576 group by v15;
create or replace view aggJoin3748746031418175240 as select v15, v9 from aggJoin2936041546363688477 join aggView6593729508090027615 using(v15);
create or replace view aggView977978196994521652 as select v15 from aggJoin3748746031418175240 group by v15;
create or replace view aggJoin1416412075349197231 as select title as v16 from title as t, aggView977978196994521652 where t.id=aggView977978196994521652.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin1416412075349197231;
