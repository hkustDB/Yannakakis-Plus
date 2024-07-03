create or replace view aggView1384685937160561228 as select id as v3 from info_type as it where info= 'bottom 10 rank';
create or replace view aggJoin6772191788540252399 as select movie_id as v15 from movie_info_idx as mi_idx, aggView1384685937160561228 where mi_idx.info_type_id=aggView1384685937160561228.v3;
create or replace view aggView280645578262901294 as select v15 from aggJoin6772191788540252399 group by v15;
create or replace view aggJoin2363026321295286491 as select id as v15, title as v16, production_year as v19 from title as t, aggView280645578262901294 where t.id=aggView280645578262901294.v15 and production_year<=2010 and production_year>=2005;
create or replace view aggView6056143235872679497 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin2663801623310689483 as select movie_id as v15, note as v9 from movie_companies as mc, aggView6056143235872679497 where mc.company_type_id=aggView6056143235872679497.v1 and note NOT LIKE '%(as Metro-Goldwyn-Mayer Pictures)%';
create or replace view aggView7361190294375447152 as select v15, MIN(v16) as v28, MIN(v19) as v29 from aggJoin2363026321295286491 group by v15;
create or replace view aggJoin4972173693768071522 as select v9, v28, v29 from aggJoin2663801623310689483 join aggView7361190294375447152 using(v15);
select MIN(v9) as v27,MIN(v28) as v28,MIN(v29) as v29 from aggJoin4972173693768071522;
