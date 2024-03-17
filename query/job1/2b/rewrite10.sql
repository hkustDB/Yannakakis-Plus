create or replace view aggView1704171137015352303 as select id as v1 from company_name as cn where country_code= '[nl]';
create or replace view aggJoin9219475349955696743 as select movie_id as v12 from movie_companies as mc, aggView1704171137015352303 where mc.company_id=aggView1704171137015352303.v1;
create or replace view aggView6569731077590818726 as select v12 from aggJoin9219475349955696743 group by v12;
create or replace view aggJoin9142504089992293383 as select id as v12, title as v20 from title as t, aggView6569731077590818726 where t.id=aggView6569731077590818726.v12;
create or replace view aggView1818954321911518773 as select id as v18 from keyword as k where keyword= 'character-name-in-title';
create or replace view aggJoin6129584056252650836 as select movie_id as v12 from movie_keyword as mk, aggView1818954321911518773 where mk.keyword_id=aggView1818954321911518773.v18;
create or replace view aggView1922650910380833247 as select v12 from aggJoin6129584056252650836 group by v12;
create or replace view aggJoin1714944915862004687 as select v20 from aggJoin9142504089992293383 join aggView1922650910380833247 using(v12);
select MIN(v20) as v31 from aggJoin1714944915862004687;
