create or replace view aggView1289962491836415234 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin1825691907509101438 as select movie_id as v12 from movie_companies as mc, aggView1289962491836415234 where mc.company_id=aggView1289962491836415234.v1;
create or replace view aggView2390839342498204584 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1534942125428250424 as select v12, v31 from aggJoin1825691907509101438 join aggView2390839342498204584 using(v12);
create or replace view aggView5437686814541705205 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin3616208714028341518 as select movie_id as v12 from movie_keyword as mk, aggView5437686814541705205 where mk.keyword_id=aggView5437686814541705205.v18;
create or replace view aggView7031904975260607249 as select v12, MIN(v31) as v31 from aggJoin1534942125428250424 group by v12,v31;
create or replace view aggJoin8488876956324911180 as select v31 from aggJoin3616208714028341518 join aggView7031904975260607249 using(v12);
select MIN(v31) as v31 from aggJoin8488876956324911180;
