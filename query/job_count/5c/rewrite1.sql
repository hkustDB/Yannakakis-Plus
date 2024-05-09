create or replace view aggView9172693775581651080 as select id as v3 from info_type as it;
create or replace view aggJoin1701745170933778332 as select movie_id as v15, info as v13 from movie_info as mi, aggView9172693775581651080 where mi.info_type_id=aggView9172693775581651080.v3 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German','USA','American');
create or replace view aggView9033848669771853181 as select v15, COUNT(*) as annot from aggJoin1701745170933778332 group by v15;
create or replace view aggJoin1745923282329860054 as select id as v15, production_year as v19, annot from title as t, aggView9033848669771853181 where t.id=aggView9033848669771853181.v15 and production_year>1990;
create or replace view aggView1625665213538240576 as select v15, SUM(annot) as annot from aggJoin1745923282329860054 group by v15;
create or replace view aggJoin697334183227453941 as select company_type_id as v1, note as v9, annot from movie_companies as mc, aggView1625665213538240576 where mc.movie_id=aggView1625665213538240576.v15 and note LIKE '%(USA)%' and note NOT LIKE '%(TV)%';
create or replace view aggView3477300065904158463 as select v1, SUM(annot) as annot from aggJoin697334183227453941 group by v1;
create or replace view aggJoin4543381632331394307 as select kind as v2, annot from company_type as ct, aggView3477300065904158463 where ct.id=aggView3477300065904158463.v1 and kind= 'production companies';
select SUM(annot) as v27 from aggJoin4543381632331394307;
