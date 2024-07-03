create or replace view aggView5652848239452551540 as select id as v3 from info_type as it;
create or replace view aggJoin7157456534926700905 as select movie_id as v15, info as v13 from movie_info as mi, aggView5652848239452551540 where mi.info_type_id=aggView5652848239452551540.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView4276100589863182407 as select v15 from aggJoin7157456534926700905 group by v15;
create or replace view aggJoin937095415849729378 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView4276100589863182407 where mc.movie_id=aggView4276100589863182407.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView9125131144267114872 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3084903198076426599 as select v15, v9 from aggJoin937095415849729378 join aggView9125131144267114872 using(v1);
create or replace view aggView2725336233396234644 as select v15 from aggJoin3084903198076426599 group by v15;
create or replace view aggJoin2459478135852529931 as select title as v16 from title as t, aggView2725336233396234644 where t.id=aggView2725336233396234644.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin2459478135852529931;
