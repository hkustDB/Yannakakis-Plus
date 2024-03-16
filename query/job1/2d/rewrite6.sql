create or replace view aggView1333847431139521684 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin6937501102809756473 as select movie_id as v12 from movie_companies as mc, aggView1333847431139521684 where mc.company_id=aggView1333847431139521684.v1;
create or replace view aggView2987752603383132296 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8246832952720345882 as select movie_id as v12 from movie_keyword as mk, aggView2987752603383132296 where mk.keyword_id=aggView2987752603383132296.v18;
create or replace view aggView2687968795693391350 as select v12 from aggJoin8246832952720345882 group by v12;
create or replace view aggJoin7713529762259614601 as select v12 from aggJoin6937501102809756473 join aggView2687968795693391350 using(v12);
create or replace view aggView975954661510729995 as select v12 from aggJoin7713529762259614601 group by v12;
create or replace view aggJoin5986256433378766216 as select title as v20 from title as t, aggView975954661510729995 where t.id=aggView975954661510729995.v12;
select MIN(v20) as v31 from aggJoin5986256433378766216;
