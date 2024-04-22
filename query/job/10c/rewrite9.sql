create or replace view aggJoin1304855157388240066 as (
with aggView8366991985125827779 as (select id as v31, title as v44 from title as t where production_year>1990)
select movie_id as v31, company_id as v15, company_type_id as v22, v44 from movie_companies as mc, aggView8366991985125827779 where mc.movie_id=aggView8366991985125827779.v31);
create or replace view aggJoin743706384941800718 as (
with aggView1382152377438656504 as (select id as v1, name as v43 from char_name as chn)
select movie_id as v31, note as v12, role_id as v29, v43 from cast_info as ci, aggView1382152377438656504 where ci.person_role_id=aggView1382152377438656504.v1 and note LIKE '%(producer)%');
create or replace view aggJoin4737419465789380372 as (
with aggView4649920341760767505 as (select id as v22 from company_type as ct)
select v31, v15, v44 from aggJoin1304855157388240066 join aggView4649920341760767505 using(v22));
create or replace view aggJoin6080845624412073984 as (
with aggView889703008178928009 as (select id as v29 from role_type as rt)
select v31, v12, v43 from aggJoin743706384941800718 join aggView889703008178928009 using(v29));
create or replace view aggJoin6694634017466615436 as (
with aggView2604350745949269734 as (select id as v15 from company_name as cn where country_code= '[us]')
select v31, v44 from aggJoin4737419465789380372 join aggView2604350745949269734 using(v15));
create or replace view aggJoin9106330200117596715 as (
with aggView8758895232919113659 as (select v31, MIN(v43) as v43 from aggJoin6080845624412073984 group by v31,v43)
select v44 as v44, v43 from aggJoin6694634017466615436 join aggView8758895232919113659 using(v31));
select MIN(v43) as v43,MIN(v44) as v44 from aggJoin9106330200117596715;
