create or replace view aggView5732783866091386139 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin4951483929734619614 as select movie_id as v15 from movie_info_idx as mi_idx, aggView5732783866091386139 where mi_idx.info_type_id=aggView5732783866091386139.v3;
create or replace view aggView7391526857275667002 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin8213401134086865578 as select movie_id as v15, note as v9 from movie_companies as mc, aggView7391526857275667002 where mc.company_type_id=aggView7391526857275667002.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView3049229752083528697 as select v15, COUNT(*) as annot from aggJoin4951483929734619614 group by v15;
create or replace view aggJoin5556964932058292646 as select id as v15, production_year as v19, annot from title as t, aggView3049229752083528697 where t.id=aggView3049229752083528697.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView7841448292334261790 as select v15, SUM(annot) as annot from aggJoin5556964932058292646 group by v15;
create or replace view aggJoin1632988052359453727 as select annot from aggJoin8213401134086865578 join aggView7841448292334261790 using(v15);
select SUM(annot) as v27 from aggJoin1632988052359453727;
