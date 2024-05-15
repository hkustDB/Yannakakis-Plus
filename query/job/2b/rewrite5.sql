create or replace view aggView1236798613782520639 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin2932242161665580299 as select movie_id as v12 from movie_companies as mc, aggView1236798613782520639 where mc.company_id=aggView1236798613782520639.v1;
create or replace view aggView8868955789668687530 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5151451371874699509 as select movie_id as v12, keyword_id as v18, v31 from movie_keyword as mk, aggView8868955789668687530 where mk.movie_id=aggView8868955789668687530.v12;
create or replace view aggView5878616137765369554 as select v12 from aggJoin2932242161665580299 group by v12;
create or replace view aggJoin5951773557319803310 as select v18, v31 as v31 from aggJoin5151451371874699509 join aggView5878616137765369554 using(v12);
create or replace view aggView4594194642271227095 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin5768147252527384262 as select v31 from aggJoin5951773557319803310 join aggView4594194642271227095 using(v18);
select MIN(v31) as v31 from aggJoin5768147252527384262;
