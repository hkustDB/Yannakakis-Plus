create or replace view aggView2820112107138883556 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin9127416331665718177 as select movie_id as v12 from movie_companies as mc, aggView2820112107138883556 where mc.company_id=aggView2820112107138883556.v1;
create or replace view aggView2748176214131201905 as select v12 from aggJoin9127416331665718177 group by v12;
create or replace view aggJoin7224080709130266751 as select id as v12, title as v20 from title as t, aggView2748176214131201905 where t.id=aggView2748176214131201905.v12;
create or replace view aggView7591591898714748831 as select v12, MIN(v20) as v31 from aggJoin7224080709130266751 group by v12;
create or replace view aggJoin4410468931242186387 as select keyword_id as v18, v31 from movie_keyword as mk, aggView7591591898714748831 where mk.movie_id=aggView7591591898714748831.v12;
create or replace view aggView7313941748881540484 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin4495280515915481392 as select v31 from aggJoin4410468931242186387 join aggView7313941748881540484 using(v18);
select MIN(v31) as v31 from aggJoin4495280515915481392;
