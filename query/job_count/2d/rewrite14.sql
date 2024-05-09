create or replace view aggView4015461749483626425 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8915087133482016667 as select movie_id as v12 from movie_companies as mc, aggView4015461749483626425 where mc.company_id=aggView4015461749483626425.v1;
create or replace view aggView3014450662092139886 as select v12, COUNT(*) as annot from aggJoin8915087133482016667 group by v12;
create or replace view aggJoin5926909280513387536 as select id as v12, annot from title as t, aggView3014450662092139886 where t.id=aggView3014450662092139886.v12;
create or replace view aggView1008960404976398295 as select v12, SUM(annot) as annot from aggJoin5926909280513387536 group by v12;
create or replace view aggJoin8580947862725390760 as select keyword_id as v18, annot from movie_keyword as mk, aggView1008960404976398295 where mk.movie_id=aggView1008960404976398295.v12;
create or replace view aggView8238602369100010539 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4811112833661439881 as select annot from aggJoin8580947862725390760 join aggView8238602369100010539 using(v18);
select SUM(annot) as v31 from aggJoin4811112833661439881;
