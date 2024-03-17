create or replace view aggView1967693604117614074 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin4825880804032526649 as select movie_id as v12 from movie_companies as mc, aggView1967693604117614074 where mc.company_id=aggView1967693604117614074.v1;
create or replace view aggView1661500132365081203 as select v12 from aggJoin4825880804032526649 group by v12;
create or replace view aggJoin2096767787627604915 as select movie_id as v12, keyword_id as v18 from movie_keyword as mk, aggView1661500132365081203 where mk.movie_id=aggView1661500132365081203.v12;
create or replace view aggView4400569051884244212 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8663639553219381799 as select v12 from aggJoin2096767787627604915 join aggView4400569051884244212 using(v18);
create or replace view aggView1290301112376109472 as select v12 from aggJoin8663639553219381799 group by v12;
create or replace view aggJoin2195589694506319022 as select title as v20 from title as t, aggView1290301112376109472 where t.id=aggView1290301112376109472.v12;
select MIN(v20) as v31 from aggJoin2195589694506319022;
