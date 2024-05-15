create or replace view aggView6843135234570178925 as select id as v1 from company_name as cn where country_code= '[us]';
create or replace view aggJoin8385636645901095153 as select movie_id as v12 from movie_companies as mc, aggView6843135234570178925 where mc.company_id=aggView6843135234570178925.v1;
create or replace view aggView3153857648009301564 as select v12 from aggJoin8385636645901095153 group by v12;
create or replace view aggJoin8435114090250734730 as select id as v12, title as v20 from title as t, aggView3153857648009301564 where t.id=aggView3153857648009301564.v12;
create or replace view aggView7126553267223877496 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin8926841987344850913 as select movie_id as v12 from movie_keyword as mk, aggView7126553267223877496 where mk.keyword_id=aggView7126553267223877496.v18;
create or replace view aggView402745012487006771 as select v12, MIN(v20) as v31 from aggJoin8435114090250734730 group by v12;
create or replace view aggJoin819136848633820866 as select v31 from aggJoin8926841987344850913 join aggView402745012487006771 using(v12);
select MIN(v31) as v31 from aggJoin819136848633820866;
