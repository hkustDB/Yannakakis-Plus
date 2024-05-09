create or replace view aggView5112052619440086474 as select id as v1 from company_type as ct where kind= 'production companies';
create or replace view aggJoin7910353199064039000 as select movie_id as v15, note as v9 from movie_companies as mc, aggView5112052619440086474 where mc.company_type_id=aggView5112052619440086474.v1 and note LIKE '%(theatrical)%' and note LIKE '%(France)%';
create or replace view aggView8545466408237028831 as select v15, COUNT(*) as annot from aggJoin7910353199064039000 group by v15;
create or replace view aggJoin4366242183387613282 as select id as v15, production_year as v19, annot from title as t, aggView8545466408237028831 where t.id=aggView8545466408237028831.v15 and production_year>2005;
create or replace view aggView1359662698103439931 as select v15, SUM(annot) as annot from aggJoin4366242183387613282 group by v15;
create or replace view aggJoin3167859763910490086 as select info_type_id as v3, info as v13, annot from movie_info as mi, aggView1359662698103439931 where mi.movie_id=aggView1359662698103439931.v15 and info IN ('Sweden','Norway','Germany','Denmark','Swedish','Denish','Norwegian','German');
create or replace view aggView7596631555622083033 as select v3, SUM(annot) as annot from aggJoin3167859763910490086 group by v3;
create or replace view aggJoin2064667234042923121 as select annot from info_type as it, aggView7596631555622083033 where it.id=aggView7596631555622083033.v3;
select SUM(annot) as v27 from aggJoin2064667234042923121;
