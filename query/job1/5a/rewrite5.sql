create or replace view aggView4811880654081936126 as select id as v15, title as v27 from title as t where production_year>2005;
create or replace view aggJoin3133828128316651915 as select movie_id as v15, company_type_id as v1, note as v9, v27 from movie_companies as mc, aggView4811880654081936126 where mc.movie_id=aggView4811880654081936126.v15 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView1945981296653865404 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin3764526185340411900 as select v15, v9, v27 from aggJoin3133828128316651915 join aggView1945981296653865404 using(v1);
create or replace view aggView8052192041360454928 as select v15, MIN(v27) as v27 from aggJoin3764526185340411900 group by v15;
create or replace view aggJoin7558550813665360906 as select info_type_id as v3, info as v13, v27 from movie_info as mi, aggView8052192041360454928 where mi.movie_id=aggView8052192041360454928.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7701061538835961036 as select id as v3 from info_type as it;
create or replace view aggJoin3193623754615433177 as select v13, v27 from aggJoin7558550813665360906 join aggView7701061538835961036 using(v3);
select MIN(v27) as v27 from aggJoin3193623754615433177;
