create or replace view aggView4085657943170858555 as select id as v3 from info_type as it;
create or replace view aggJoin4564048427605969466 as select movie_id as v15, info as v13 from movie_info as mi, aggView4085657943170858555 where mi.info_type_id=aggView4085657943170858555.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView2539477303726502629 as select v15 from aggJoin4564048427605969466 group by v15;
create or replace view aggJoin1283133748909703228 as select movie_id as v15, company_type_id as v1, note as v9 from movie_companies as mc, aggView2539477303726502629 where mc.movie_id=aggView2539477303726502629.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView5326263022352520310 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin6453279544462091926 as select v15, v9 from aggJoin1283133748909703228 join aggView5326263022352520310 using(v1);
create or replace view aggView179053899621428277 as select v15 from aggJoin6453279544462091926 group by v15;
create or replace view aggJoin2239590948994725185 as select title as v16 from title as t, aggView179053899621428277 where t.id=aggView179053899621428277.v15 and production_year>1990;
select MIN(v16) as v27 from aggJoin2239590948994725185;
