create or replace view aggView4869206015045092398 as select id as v12, title as v31 from title as t;
create or replace view aggJoin9193156550112534714 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView4869206015045092398 where mc.movie_id=aggView4869206015045092398.v12;
create or replace view aggView5891932519592309494 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin8915110820425777487 as select v12, v31 from aggJoin9193156550112534714 join aggView5891932519592309494 using(v1);
create or replace view aggView1886223713048171139 as select v12, MIN(v31) as v31 from aggJoin8915110820425777487 group by v12;
create or replace view aggJoin6994650838762360116 as select keyword_id as v18, v31 from movie_keyword as mk, aggView1886223713048171139 where mk.movie_id=aggView1886223713048171139.v12;
create or replace view aggView2513111153728955260 as select v18, MIN(v31) as v31 from aggJoin6994650838762360116 group by v18;
create or replace view aggJoin5177290598910073543 as select keyword as v9, v31 from keyword as k, aggView2513111153728955260 where k.id=aggView2513111153728955260.v18 and keyword= 'character-name-in-title';
select MIN(v31) as v31 from aggJoin5177290598910073543;
