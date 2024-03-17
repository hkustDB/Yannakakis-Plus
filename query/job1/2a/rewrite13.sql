create or replace view aggView1326826102847839618 as select id as v12, title as v31 from title as t;
create or replace view aggJoin5881355296952400326 as select movie_id as v12, company_id as v1, v31 from movie_companies as mc, aggView1326826102847839618 where mc.movie_id=aggView1326826102847839618.v12;
create or replace view aggView8147067264070884666 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8651242293168720219 as select movie_id as v12 from movie_keyword as mk, aggView8147067264070884666 where mk.keyword_id=aggView8147067264070884666.v18;
create or replace view aggView416515335731792730 as select v12 from aggJoin8651242293168720219 group by v12;
create or replace view aggJoin2115915506089500138 as select v1, v31 as v31 from aggJoin5881355296952400326 join aggView416515335731792730 using(v12);
create or replace view aggView5774632104562573202 as select id as v1 from company_name as cn where country_code= '[de]';
create or replace view aggJoin279459200822688026 as select v31 from aggJoin2115915506089500138 join aggView5774632104562573202 using(v1);
select MIN(v31) as v31 from aggJoin279459200822688026;
