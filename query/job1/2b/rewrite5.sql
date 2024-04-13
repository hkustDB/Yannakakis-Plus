create or replace view aggView4019480547118394592 as select id as v12, title as v31 from title as t;
create or replace view aggJoin1905741823748577301 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView4019480547118394592 where mk.movie_id=aggView4019480547118394592.v12;
create or replace view aggView7555032657966684128 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin4126256775592535437 as select movie_id as v12 from movie_companies as mc, aggView7555032657966684128 where mc.company_id=aggView7555032657966684128.v1;
create or replace view aggView5067519375819262522 as select v12 from aggJoin4126256775592535437 group by v12;
create or replace view aggJoin2971844148973166837 as select v18, v31 as v31 from aggJoin1905741823748577301 join aggView5067519375819262522 using(v12);
create or replace view aggView1253545547345655904 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6110436751175387816 as select v31 from aggJoin2971844148973166837 join aggView1253545547345655904 using(v18);
select MIN(v31) as v31 from aggJoin6110436751175387816;
