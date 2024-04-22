create or replace view aggJoin5241404788539995964 as (
with aggView11564215932369812 as (select id as v31, title as v44 from title as t where production_year>2010)
select movie_id as v31, person_role_id as v1, note as v12, role_id as v29, v44 from cast_info as ci, aggView11564215932369812 where ci.movie_id=aggView11564215932369812.v31 and note LIKE '%(producer)%');
create or replace view aggJoin2081781465061139624 as (
with aggView8692976019577219429 as (select id as v1, name as v43 from char_name as chn)
select v31, v12, v29, v44, v43 from aggJoin5241404788539995964 join aggView8692976019577219429 using(v1));
create or replace view aggJoin12451727030815749 as (
with aggView294212904311385288 as (select id as v29 from role_type as rt where role= 'actor')
select v31, v12, v44, v43 from aggJoin2081781465061139624 join aggView294212904311385288 using(v29));
create or replace view aggJoin6713369766006504991 as (
with aggView8331031310033730485 as (select id as v22 from company_type as ct)
select movie_id as v31, company_id as v15 from movie_companies as mc, aggView8331031310033730485 where mc.company_type_id=aggView8331031310033730485.v22);
create or replace view aggJoin3485007813592172305 as (
with aggView3469946029830266947 as (select id as v15 from company_name as cn where country_code= '[ru]')
select v31 from aggJoin6713369766006504991 join aggView3469946029830266947 using(v15));
create or replace view aggJoin7216141715881865356 as (
with aggView5636929556776360382 as (select v31, MIN(v44) as v44, MIN(v43) as v43 from aggJoin12451727030815749 group by v31,v43,v44)
select v44, v43 from aggJoin3485007813592172305 join aggView5636929556776360382 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin7216141715881865356;
