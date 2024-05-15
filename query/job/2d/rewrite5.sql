create or replace view aggView2811272438932815702 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin5169761486468069930 as select movie_id as v12 from movie_companies as mc, aggView2811272438932815702 where mc.company_id=aggView2811272438932815702.v1;
create or replace view aggView4903674645464340026 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6932695417737259994 as select movie_id as v12 from movie_keyword as mk, aggView4903674645464340026 where mk.keyword_id=aggView4903674645464340026.v18;
create or replace view aggView9143364448925272414 as select id as v12, title as v31 from title as t;
create or replace view aggJoin6954308831411637489 as select v12, v31 from aggJoin6932695417737259994 join aggView9143364448925272414 using(v12);
create or replace view aggView2208894697591891350 as select v12 from aggJoin5169761486468069930 group by v12;
create or replace view aggJoin1684963730918807150 as select v31 as v31 from aggJoin6954308831411637489 join aggView2208894697591891350 using(v12);
select MIN(v31) as v31 from aggJoin1684963730918807150;
